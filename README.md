# base64-encoding-playground

The purpose of this is to find out how much of something we can encode into a string, where we have a limit on the string's length, and want to use NSData's native base-64 encoding.

The motivation behind this is trying to encode arbitrary data into the Messages framework's MSMessage.url property, while only using native frameworks and language features.

My specific use-case was: how many CGPoints could I contain in MSMessage.url, where the string-length cannot exceed 5000? This playground answers that question with: 234. Note that a minimal URL scheme starts with "?d:", hence the practical MAX_STRING_LENGTH of 4997.
