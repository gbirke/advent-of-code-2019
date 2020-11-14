use fft::fft;
use std::fs;
use std::str;

fn read_input() -> Vec<u8> {
    let content = fs::read_to_string("input.txt").expect("input.txt not found");
    content.trim().as_bytes().iter().map(|b| b - 48 ).collect()
}

fn main() {
    let mut result: Vec<u8> = fft(&read_input(), 100);
    result.truncate(8);
    let bytes: Vec<u8> = result.iter().map(|b| b+48).collect();
    println!("{:?}", str::from_utf8(&bytes).expect("could not convert into utf8"))
}
