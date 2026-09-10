
use std::process::exit;

#[macro_use] extern crate clap;
use clap::{Arg, SubCommand};
use failure::Fail;

mod errors;
mod loader;
mod meta;

use crate::errors::AppResultU;



fn main() {
    if let Err(err) = app() {
        let mut fail: &Fail = &err;
        let mut message = err.to_string();
        while let Some(cause) = fail.cause() {
            message.push_str(&format!("\n\tcaused by: {}", cause));
            fail = cause;
        }
        eprintln!("{}\n", message);
        exit(1);
    }
}


fn app() -> AppResultU {
    let app = app_from_crate!()
        .subcommand(SubCommand::with_name("load")
                    .alias("l")
                    .about("Load directory")
                    .arg(Arg::with_name("directory")
                         .required(true)));

    let matches = app.get_matches();

    if let Some(ref matches) = matches.subcommand_matches("load") {
        let directory: &str = matches.value_of("directory").unwrap(); // Required
        println!("Load directory: {}", directory);
        crate::loader::load(&directory)?;
    }

    Ok(())
}
