function decodeHtmlEntities(html) {
    const entitiesMap = {
        '&quot;': '"',
        '&lt;': '<',
        '&gt;': '>',
        '&amp;': '&',
    };
    return html.replace(/&quot;|&lt;|&gt;|&amp;/g, (match) => entitiesMap[match]);
}

export function parseContent(htmlContent) {
    const regex = /<pre><code[^>]*>([\s\S]*?)<\/code><\/pre>/g;
    let match;
    let blocks = [];
    let lastIndex = 0;

    while ((match = regex.exec(htmlContent)) !== null) {
        const { index } = match;
        if (index > lastIndex) {
            const textContent = htmlContent.substring(lastIndex, index);
            blocks.push({ type: 'text', content: decodeHtmlEntities(textContent) });
        }
        const codeContent = match[1];
        blocks.push({ type: 'code', content: decodeHtmlEntities(codeContent) });
        lastIndex = index + match[0].length;
    }
    if (lastIndex < htmlContent.length) {
        const remainingText = htmlContent.substring(lastIndex);
        blocks.push({ type: 'text', content: decodeHtmlEntities(remainingText) });
    }
    return blocks;
}