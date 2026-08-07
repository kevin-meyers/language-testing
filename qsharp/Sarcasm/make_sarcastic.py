import sys
import qsharp
from Sarcasm import GenerateRandomBit

def should_capitalize():
    return GenerateRandomBit.simulate()

def to_sarcasm(sentence):
    result = ""
    for letter in sentence:
        if should_capitalize():
            result += letter.upper()

        else:
            result += letter.lower()

    return result

if __name__ == "__main__":
    text = sys.argv[1]
    print(to_sarcasm(text))

