import math

class first_last_list(list):
    def __iter__(self):
        for i in range(math.ceil(len(self) / 2)):
            yield self[i]
            if i < len(self) // 2:
                yield self[len(self) - i - 1]



def first_last(l):
    def inner(first, last):
        print(l[first])
        if first >= last:
            return

        print(l[last])
        inner(first + 1, last - 1)

    return inner(0, len(l) - 1)
