<script>
  // components.
  import Header    from "../../../components/general/Header.svelte";
  import Content   from "../../../components/general/Content.svelte";
  import Footer    from "../../../components/general/Footer.svelte";
  import FaCopy    from 'svelte-icons/fa/FaCopy.svelte';
  import FaCheck   from 'svelte-icons/fa/FaCheck.svelte'

  // system.
  import { onMount } from "svelte";
  import { page }    from '$app/stores';

  // highlights.
  import {Highlight, LineNumbers } from "svelte-highlight";
  import golang                    from "svelte-highlight/languages/go";
  import theme_light               from "svelte-highlight/styles/default";
  import theme_dark                from "svelte-highlight/styles/github-dark";

  // static.
  import { theme }        from '../../../lib/theme.js';
  import { router }       from '../../../stores/router.js';
  import { parseContent } from '../../../lib/content_parser.js';

  // content.
  let htmlContent = `{{index . "main.md"}}`;
  let activeButtonIndex = null;
  let blocks = [];

  onMount(() => {
    blocks = parseContent(htmlContent);

    theme.subscribe(value => {
      updateTheme(value);
    });
    updateTheme($theme);
  });

  // clipboard.
  async function copy(content, index) {
    await navigator.clipboard.writeText(content);
    activeButtonIndex = index;
  }
  function updateTheme(theme) {
    if (typeof window !== "undefined") {
      const previousStyles = document.head.querySelector('style[data-theme="custom"]');
      if (previousStyles) {
        document.head.removeChild(previousStyles);
      }
      const style = document.createElement('style');
      style.setAttribute('data-theme', 'custom');
      style.textContent = theme === 'dark' ? theme_dark : theme_light;
      document.head.appendChild(style);
    }
  }
</script>

<svelte:head>
    <title>{$router[$page.url.pathname].static.title || 'GoLang etc.'}</title>
    {@html theme_light}
</svelte:head>

<Header/>
    <Content>
        <div class="article">
            <div class="global__block-main global__border-main">
                {#each blocks as block, index (block.id)}
                    {#if block.type === 'code'}
                        <div class="code-btn">
                            <button class="global__btn-main" on:click={() => copy(block.content, index)}>
                                {#if index === activeButtonIndex}
                                    <div class="icon"><FaCheck /></div>
                                {:else}
                                    <div class="icon"><FaCopy /></div>
                                {/if}
                            </button>
                        </div>
                        <Highlight code={block.content} language={golang} let:highlighted>
                            <LineNumbers {highlighted} style="border-radius: 6px"/>
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
        font-size: 1em;
    }
    .code-btn{
        display: flex;
        justify-content: flex-end;
        padding: 4px 0 4px 0;
    }
    .icon{
        padding: 4px;
        height: 16px;
        width: 16px;
    }

    @media (max-width: 1020px) {
        .article {
            padding: 0 5% 0 5%;
            font-size: .9em;
        }
    }
    @media (max-width: 768px) {
        .article {
            padding: 0;
            font-size: .8em;
        }
    }
</style>