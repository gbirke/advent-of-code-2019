use fft::fft;

fn main() {
    let result = fft(&[1, 2, 3], 1);
    println!("{:?}", result);
}
