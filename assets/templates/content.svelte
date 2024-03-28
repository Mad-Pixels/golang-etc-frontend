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
  import typescript from "svelte-highlight/languages/go";
  import {Highlight, LineNumbers } from "svelte-highlight";
  import atomOneDark               from "svelte-highlight/styles/github-dark";

  // static.
  import { router }       from '../../../stores/router.js';
  import { parseContent } from '../../../lib/content_parser.js';

  // content.
  let htmlContent = `{{index . "main.md"}}`;
  let activeButtonIndex = null;
  let blocks = [];
  onMount(() => { blocks = parseContent(htmlContent); });

  // clipboard.
  async function copy(content, index) {
    await navigator.clipboard.writeText(content);
    activeButtonIndex = index;
  }
</script>

<svelte:head>
    <title>{$router[$page.url.pathname].static.title || 'GoLang etc.'}</title>
    {@html atomOneDark}
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
        }
    }
    @media (max-width: 768px) {
        .article {
            padding: 0;
        }
    }
</style>