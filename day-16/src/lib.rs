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

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn pattern_first_digit() {
        let result: Vec<i8> = pattern(1).take(7).collect();

        assert_eq!(vec![1, 0, -1, 0, 1, 0, -1], result);
    }

    #[test]
    fn pattern_second_digit() {
        let result: Vec<i8> = pattern(2).take(15).collect();

        assert_eq!(vec![0, 1, 1, 0, 0, -1, -1, 0, 0, 1, 1, 0, 0, -1, -1], result);
    }

    #[test]
    fn pattern_third_digit() {
        let result: Vec<i8> = pattern(3).take(20).collect();

        assert_eq!(vec![0, 0, 1, 1, 1, 0, 0, 0, -1, -1, -1, 0, 0, 0, 1, 1, 1, 0, 0, 0], result);
    }
}
