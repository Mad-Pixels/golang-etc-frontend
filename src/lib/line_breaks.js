export function lineBreaks(str, maxLineLength) {
  let currentLineLength = 0;
  let result = '';

  for (let i = 0; i < str.length; i++) {
    const char = str[i];
    let nextChar = i + 1 < str.length ? str[i + 1] : '';

    result += char;
    currentLineLength++;
    if (currentLineLength >= maxLineLength) {
      if (nextChar === ' ') {
        i++;
      }
      result += '\n';
      currentLineLength = 0;
    } else if (char === ' ' && nextChar && currentLineLength + nextChar.length > maxLineLength) {
      result += '\n';
      currentLineLength = 0;
    }
  }
  return result;
}
