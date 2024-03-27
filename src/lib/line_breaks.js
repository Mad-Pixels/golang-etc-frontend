export function lineBreaks(str, maxLineLength) {
  if (str.length <= maxLineLength) return str;

  const words = str.split(' ');
  let result = [];
  let currentLine = '';

  words.forEach(word => {
    if (currentLine.length + word.length + 1 <= maxLineLength) {
      currentLine += (currentLine.length > 0 ? ' ' : '') + word;
    } else {
      if (currentLine.length > 0) {
        result.push(currentLine);
      }
      currentLine = word;
    }
  });
  if (currentLine.length > 0) {
    result.push(currentLine);
  }
  return result.join('\n');
}
