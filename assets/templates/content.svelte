<script>
  // components.
  import Header    from "../../../components/general/Header.svelte";
  import Content   from "../../../components/general/Content.svelte";
  import Footer    from "../../../components/general/Footer.svelte";

  // system.
  import { onMount } from "svelte";
  import { page }    from '$app/stores';

  // highlights.
  import typescript from "svelte-highlight/languages/go";
  import {Highlight, LineNumbers } from "svelte-highlight";
  import atomOneDark               from "svelte-highlight/styles/atom-one-dark";

  // static.
  import { router }       from '../../../stores/router.js';
  import { parseContent } from '../../../lib/content_parser.js';

  // content.
  let htmlContent = `{{index . "main.md"}}`;
  let blocks = [];
  onMount(() => { blocks = parseContent(htmlContent); });
</script>

<svelte:head>
    <title>{$router[$page.url.pathname].static.title || 'GoLang etc.'}</title>
    {@html atomOneDark}
</svelte:head>

<Header/>
    <Content>
        <div class="article">
            <div class="block-content">
                {#each blocks as block}
                    {#if block.type === 'code'}
                        <Highlight code={block.content} language={typescript} let:highlighted>
                            <LineNumbers {highlighted} />
                        </Highlight>
                    {:else}
                        {@html block.content}
                    {/if}
                {/each}
            </div>
        </div>
    </Content>
<Footer/>

<style>
    .article {
        padding: 0 10% 0 10%;
    }

    @media (max-width: 1020px) {
        .article {
            padding: 0 5% 0 5%;
        }
    }
    @media (max-width: 768px) {
        .article {
            padding: 0;
        }
    }
</style>