use std::fs::OpenOptions;

let mut file = OpenOptions::new().read(true).write(false).append(false).create(false).truncate(false).open(&file)?;
file.write_all(data)?;
