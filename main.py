class KMP:
    def __init__(self, pattern):
        self.pattern = pattern
        self.pi = [0] * len(pattern)
        self.compute_pi()

    def compute_pi(self):
        j = 0
        for i in range(1, len(self.pattern)):
            while j > 0 and self.pattern[j] != self.pattern[i]:
                j = self.pi[j - 1]
            if self.pattern[j] == self.pattern[i]:
                j += 1
            self.pi[i] = j

    def search(self, text):
        j = 0
        indices = []
        for i in range(len(text)):
            while j > 0 and text[i] != self.pattern[j]:
                j = self.pi[j - 1]
            if text[i] == self.pattern[j]:
                j += 1
            if j == len(self.pattern):
                indices.append(i - j + 1)
                j = self.pi[j - 1]
        return indices

def main():
    pattern = "abc"
    text = "abcabcabc"
    kmp = KMP(pattern)
    indices = kmp.search(text)
    for index in indices:
        print(f"Pattern found at index {index}")

    pattern = "xyz"
    text = "abcdxyzabcdxyz"
    kmp = KMP(pattern)
    indices = kmp.search(text)
    for index in indices:
        print(f"Pattern found at index {index}")

    pattern = "abcabc"
    text = "abcabcabcabcabc"
    kmp = KMP(pattern)
    indices = kmp.search(text)
    for index in indices:
        print(f"Pattern found at index {index}")

    pattern = "abcd"
    text = "abcdabcdabcdabcd"
    kmp = KMP(pattern)
    indices = kmp.search(text)
    for index in indices:
        print(f"Pattern found at index {index}")

if __name__ == "__main__":
    main()