
#[macro_use] extern crate clap;
use clap::{Arg, SubCommand};

mod errors;

use crate::errors::{AppError, AppResultU};



fn main() {
    match app() {
        Err(AppError::Void) | Ok(()) => (),
        Err(err) => {
            eprintln!("{}", err);
            std::process::exit(1);
        },
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
