use base64::{engine::general_purpose::STANDARD, Engine};
use image::codecs::jpeg::JpegEncoder;
use image::{ImageFormat, Luma};
use qrcode::render::svg;
use qrcode::{EcLevel, QrCode};
use std::io::Cursor;

use rustler::types::atom::ok;
use rustler::{Atom, Binary, Env, Error, NifStruct, NifUnitEnum, OwnedBinary};

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
    let svg = code
        .render::<svg::Color>()
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
    Ok((ok(), STANDARD.encode(&bytes)))
}

fn create_qr_image(data: &str, opts: Options) -> Vec<u8> {
    let code = QrCode::with_error_correction_level(data.as_bytes(), opts.error_correction.t()).unwrap();
    let img = code
        .render::<Luma<u8>>()
        .min_dimensions(opts.width, opts.height)
        .build();
    let mut bytes: Vec<u8> = Vec::new();
    let mut cursor = Cursor::new(&mut bytes);
    match opts.format.t().unwrap() {
        ImageFormat::Jpeg => img
            .write_with_encoder(JpegEncoder::new_with_quality(&mut cursor, 100))
            .unwrap(),
        format => img.write_to(&mut cursor, format).unwrap(),
    }
    bytes
}

fn bytes_to_binary<'a>(env: Env<'a>, bytes: Vec<u8>) -> Binary<'a> {
    let mut bin = OwnedBinary::new(bytes.len());
    bin.as_mut_slice().copy_from_slice(&bytes);
    bin.release(env)
}

#[derive(NifUnitEnum)]
pub enum ECL {
    L,
    M,
    Q,
    H,
}

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
    SVG,
}

impl Format {
    fn t(&self) -> Result<ImageFormat, &str> {
        match self {
            Format::JPG | Format::JPEG | Format::JPG64 | Format::JPEG64 => Ok(ImageFormat::Jpeg),
            Format::PNG | Format::PNG64 => Ok(ImageFormat::Png),
            _ => Err("Not Implemented"),
        }
    }
}

rustler::init!("Elixir.Qrusty.Native");
