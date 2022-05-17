use qrcode::QrCode;
use qrcode::render::svg;
use image::Luma;
use base64;
use std::io::Cursor;

use rustler::types::atom::ok;
use rustler::{Atom, Binary, Env, Error, OwnedBinary};
use image::ImageOutputFormat::{
    Png,
    Jpeg
};

#[rustler::nif]
fn svg_nif(data: &str, width: u32, height: u32) -> Result<(Atom, String), Error> {
    let code = QrCode::new(data.as_bytes()).unwrap();
    let svg = code.render::<svg::Color>()
                .min_dimensions(width, height)
                .build();
    Ok((ok(), svg))
}

#[rustler::nif]
fn png_nif<'a>(env: Env<'a>, data: &str, width: u32, height: u32) -> Result<(Atom, Binary<'a>), Error> {
    let bytes = create_qr_image(data, width, height, Png);
    Ok((ok(), bytes_to_binary(env, bytes)))
}

#[rustler::nif]
fn png64_nif(data: &str, width: u32, height: u32) -> Result<(Atom, String), Error> {
    let bytes = create_qr_image(data, width, height, Png);
    Ok((ok(), base64::encode(&bytes)))
}

#[rustler::nif]
fn jpg_nif<'a>(env: Env<'a>, data: &str, width: u32, height: u32) -> Result<(Atom, Binary<'a>), Error> {
    let bytes = create_qr_image(data, width, height, Jpeg(100));
    Ok((ok(), bytes_to_binary(env, bytes)))
}

#[rustler::nif]
fn jpg64_nif(data: &str, width: u32, height: u32) -> Result<(Atom, String), Error> {
    let bytes = create_qr_image(data, width, height, Jpeg(100));
    Ok((ok(), base64::encode(&bytes)))
}

fn create_qr_image(data: &str, width: u32, height: u32, format : image::ImageOutputFormat ) -> Vec<u8> {
    let code = QrCode::new(data.as_bytes()).unwrap();
    let img = code.render::<Luma<u8>>()
                .min_dimensions(width, height)
                .build();
    let mut bytes: Vec<u8> = Vec::new();
    img.write_to(&mut Cursor::new(&mut bytes), format).unwrap();
    bytes
}

fn bytes_to_binary<'a>(env: Env<'a>, bytes: Vec<u8>) -> Binary {
    let mut bin = OwnedBinary::new(bytes.len()).unwrap();
    bin.as_mut_slice().copy_from_slice(&bytes);
    bin.release(env)
}

rustler::init!("Elixir.Qrusty.Native", [svg_nif, png_nif, png64_nif, jpg_nif, jpg64_nif]);