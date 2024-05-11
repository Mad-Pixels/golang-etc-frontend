export function formatHtml(data) {
  return data.replace(/\n/g, '<br>');
}

export function formatConsole(data) {
  return data.replace(/\n+$/, '').replace(/\n/g, '<br> > ');
}
