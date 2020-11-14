use std::convert::TryInto;

const PATTERN_ARRAY: [i8; 4] = [0, 1, 0, -1];

#[derive(Debug)]
struct Pattern {
    pattern_width: usize,
    position: usize,
}

impl Iterator for Pattern {
    type Item = i8;

    fn next(&mut self) -> Option<i8> {
        self.position = self.position + 1;
        let index: usize = ((self.position / self.pattern_width) % 4)
            .try_into()
            .unwrap();
        Some(PATTERN_ARRAY[index])
    }
}

fn pattern(output_position: usize) -> Pattern {
    Pattern {
        pattern_width: output_position,
        position: 0,
    }
}

fn multiply_with_pattern(digits: &[u8], output_position: usize) -> impl Iterator<Item = i8> + '_ {
    digits
        .iter()
        .zip(pattern(output_position))
        .map(|(digit, pattern_multiplier)| *digit as i8 * pattern_multiplier)
}

fn pattern_sum(digits: &[u8], output_position: usize) -> u8 {
    let result: i32 = multiply_with_pattern(digits, output_position)
        .map(|b| b as i32)
        .sum();
    (result.abs() % 10).try_into().unwrap()
}

fn transform(digits: &[u8]) -> Vec<u8> {
    (0..digits.len())
        .map(|i| pattern_sum(digits, i + 1))
        .collect()
}

fn fft(digits: &[u8], num_transforms: i32) -> Vec<u8> {
    (0..num_transforms).fold(digits.to_vec(), |acc, _i| transform(&acc))
}

#[cfg(test)]
mod tests {
    use super::*;

    // Pattern

    #[test]
    fn pattern_repeats_once_on_first_digit() {
        let result: Vec<i8> = pattern(1).take(7).collect();

        assert_eq!(vec![1, 0, -1, 0, 1, 0, -1], result);
    }

    #[test]
    fn pattern_repeats_twice_on_second_digit() {
        let result: Vec<i8> = pattern(2).take(15).collect();

        assert_eq!(
            vec![0, 1, 1, 0, 0, -1, -1, 0, 0, 1, 1, 0, 0, -1, -1],
            result
        );
    }

    #[test]
    fn pattern_repeats_three_times_on_third_digit() {
        let result: Vec<i8> = pattern(3).take(20).collect();

        assert_eq!(
            vec![0, 0, 1, 1, 1, 0, 0, 0, -1, -1, -1, 0, 0, 0, 1, 1, 1, 0, 0, 0],
            result
        );
    }

    // Multiplication

    #[test]
    fn multiply_with_pattern_first_digit() {
        let input = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
        let result: Vec<i8> = multiply_with_pattern(&input, 1).collect();

        assert_eq!(vec![1, 0, -3, 0, 5, 0, -7, 0, 9, 0], result);
    }

    #[test]
    fn multiply_with_pattern_second_digit() {
        let input = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
        let result: Vec<i8> = multiply_with_pattern(&input, 2).collect();

        assert_eq!(vec![0, 2, 3, 0, 0, -6, -7, 0, 0, 0], result)
    }

    // Transformation

    #[test]
    fn test_transform1() {
        let input = vec![1, 2, 3, 4, 5, 6, 7, 8];
        let result = transform(&input);

        assert_eq!(vec![4, 8, 2, 2, 6, 1, 5, 8], result)
    }

    #[test]
    fn test_transform2() {
        let input = vec![4, 8, 2, 2, 6, 1, 5, 8];
        let result = transform(&input);

        assert_eq!(vec![3, 4, 0, 4, 0, 4, 3, 8], result)
    }

    // FFT (multiple transformations)

    #[test]
    fn test_fft1() {
        let input = vec![
            8, 0, 8, 7, 1, 2, 2, 4, 5, 8, 5, 9, 1, 4, 5, 4, 6, 6, 1, 9, 0, 8, 3, 2, 1, 8, 6, 4, 5,
            5, 9, 5,
        ];
        let result = fft(&input, 100);

        assert_eq!(vec![2, 4, 1, 7, 6, 1, 7, 6,], &result[..8])
    }
}
