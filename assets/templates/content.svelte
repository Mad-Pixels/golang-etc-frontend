<script>
  // components.
  import Header    from "../../../components/general/Header.svelte";
  import Content   from "../../../components/general/Content.svelte";
  import Footer    from "../../../components/general/Footer.svelte";

  // static.
  import { onMount } from "svelte";
  import { page }    from '$app/stores';
  import { router }  from '../../../stores/router.js';

  let component;
  let styles;

  // highlight
  import {HighlightAuto, LineNumbers } from "svelte-highlight";
  import atomOneDark from "svelte-highlight/styles/atom-one-dark";
  onMount(async () => {
      component = (await import("svelte-highlight")).HighlightAuto;
      styles = (await import("svelte-highlight/styles/github")).default;
  });

  // content.
  let htmlContent = `{{index . "main.md"}}`
  let blocks = [];

  onMount(() => {
      parseContent();
  });
  function decodeHtml(html) {
      var txt = document.createElement('textarea');
      txt.innerHTML = html;
      return txt.value;
  }
  function parseContent() {
      const regex = /<pre><code[^>]*>([\s\S]*?)<\/code><\/pre>/g;
      let lastIndex = 0;
      blocks = [];

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
  }
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
                    <svelte:component
                            this={component}
                            langtag
                            code={block.content}
                    />
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