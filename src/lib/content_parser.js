let txtElement;

function decodeHtml(html) {
    if (!txtElement) {
        txtElement = document.createElement('textarea');
    }
    txtElement.innerHTML = html;
    return txtElement.value;
}

export function parseContent(htmlContent) {
    const regex = /<pre><code[^>]*>([\s\S]*?)<\/code><\/pre>/g;
    let lastIndex = 0;
    let blocks = [];

    htmlContent.replace(regex, (match, codeContent, index) => {
        if (index > lastIndex) {
            blocks.push({ type: 'text', content: decodeHtml(htmlContent.slice(lastIndex, index)) });
        }
        blocks.push({ type: 'code', content: decodeHtml(codeContent) });
        lastIndex = index + match.length;
    });
    if (lastIndex < htmlContent.length) {
        blocks.push({ type: 'text', content: htmlContent.slice(lastIndex) });
    }
    return blocks;
}
