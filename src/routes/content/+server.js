export async function GET() {
  return new Response('', {
    status: 302,
    headers: { 'Location': '/' }
  });
}
export const prerender = true