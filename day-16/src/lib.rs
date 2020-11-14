use std::convert::TryInto;

const PATTERN_ARRAY: [i8; 4] = [0, 1, 0, -1];

#[derive(Debug)]
struct Pattern {
    pattern_width: u32,
    position: u32,
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

fn pattern(output_position: u32) -> Pattern {
    Pattern {
        pattern_width: output_position,
        position: 0,
    }
}

fn multiply_with_pattern(digits: Vec<i8>, output_position: u32) -> Vec<i8> {
    digits
        .iter()
        .zip(pattern(output_position))
        .map(|(digit, pattern_multiplier)| digit * pattern_multiplier)
        .collect()
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
        let result = multiply_with_pattern(input, 1);

        assert_eq!(vec![1, 0, -3, 0, 5, 0, -7, 0, 9, 0], result)
    }

    #[test]
    fn multiply_with_pattern_second_digit() {
        let input = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
        let result = multiply_with_pattern(input, 2);

        assert_eq!(vec![0, 2, 3, 0, 0, -6, -7, 0, 0, 0], result)
    }

}
