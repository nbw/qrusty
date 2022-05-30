use qrcode::{QrCode, EcLevel};
use qrcode::render::svg;
use image::ImageOutputFormat::{ Png, Jpeg };
use image::Luma;
use base64;
use std::io::Cursor;

use rustler::types::atom::ok;
use rustler::{Atom, Binary, Env, Error, NifUnitEnum, NifStruct, OwnedBinary};

#[derive(NifStruct)]
#[module = "Qrusty.Native.Options"]
struct Options {
    pub width: u32,
    pub height: u32,
    pub error_correction: ECL,
    pub format: Format,
}

#[rustler::nif]
fn svg_nif(data: &str, opts: Options) -> Result<(Atom, String), Error> {
    let code = QrCode::with_error_correction_level(data.as_bytes(), opts.error_correction.t()).unwrap();
    let svg = code.render::<svg::Color>()
                .min_dimensions(opts.width, opts.height)
                .build();
    Ok((ok(), svg))
}

#[rustler::nif]
fn image_binary_nif<'a>(env: Env<'a>, data: &str, opts: Options) -> Result<(Atom, Binary<'a>), Error> {
    let bytes = create_qr_image(data, opts);
    Ok((ok(), bytes_to_binary(env, bytes)))
}

#[rustler::nif]
fn image_base64_nif(data: &str, opts: Options) -> Result<(Atom, String), Error> {
    let bytes = create_qr_image(data, opts);
    Ok((ok(), base64::encode(&bytes)))
}

fn create_qr_image(data: &str, opts: Options) -> Vec<u8> {
    let code = QrCode::with_error_correction_level(data.as_bytes(), opts.error_correction.t()).unwrap();
    let img = code.render::<Luma<u8>>()
                .min_dimensions(opts.width, opts.height)
                .build();
    let mut bytes: Vec<u8> = Vec::new();
    img.write_to(&mut Cursor::new(&mut bytes), opts.format.t().unwrap()).unwrap();
    bytes
}

fn bytes_to_binary<'a>(env: Env<'a>, bytes: Vec<u8>) -> Binary {
    let mut bin = OwnedBinary::new(bytes.len()).unwrap();
    bin.as_mut_slice().copy_from_slice(&bytes);
    bin.release(env)
}

#[derive(NifUnitEnum)]
pub enum ECL {
    L,
    M,
    Q,
    H
}

// wrap qrcode's EcLevel enum
impl ECL {
    fn t(&self) -> EcLevel {
        match self {
            ECL::L => EcLevel::L,
            ECL::M => EcLevel::M,
            ECL::Q => EcLevel::Q,
            ECL::H => EcLevel::H,
        }
    }
}

#[derive(NifUnitEnum)]
pub enum Format {
    JPG,
    JPEG,
    PNG,
    JPG64,
    JPEG64,
    PNG64,
    SVG
}

// wrap image's ImageOutputFormat enum
impl Format {
    fn t(&self) -> Result<image::ImageOutputFormat, &str> {
        match self {
            Format::JPG    => Ok(Jpeg(100)),
            Format::JPEG   => Ok(Jpeg(100)),
            Format::PNG    => Ok(Png),
            Format::PNG64  => Ok(Png),
            Format::JPG64  => Ok(Jpeg(100)),
            Format::JPEG64 => Ok(Jpeg(100)),
            _ => Err("Not Implemented")
        }
    }
}

rustler::init!("Elixir.Qrusty.Native", [svg_nif, image_binary_nif, image_base64_nif]);