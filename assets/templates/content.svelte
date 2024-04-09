<script>
  // components.
  import Header    from "../../../components/general/Header.svelte";
  import Content   from "../../../components/general/Content.svelte";
  import Footer    from "../../../components/general/Footer.svelte";
  import FaCheck   from 'svelte-icons/fa/FaCheck.svelte';
  import FaCopy    from 'svelte-icons/fa/FaCopy.svelte';

  // icons.
  import FaTelegramPlane from 'svelte-icons/fa/FaTelegramPlane.svelte';
  import DiGithubAlt     from 'svelte-icons/di/DiGithubAlt.svelte';

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
  import { formatDate }   from '../../../lib/format_date.js';
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
        <div class="content">
            <div class="inner-container">
                <div class="metadata">
                    <div class="global__block-main global__border-main">
                        {#if $router[$page.url.pathname] && $router[$page.url.pathname].telegram.date}
                            <div class="date">
                                <b>{ formatDate($router[$page.url.pathname].telegram.date) }</b>
                            </div>
                        {/if}
                        {#if $router[$page.url.pathname] && $router[$page.url.pathname].telegram.message_id }
                            <div class="meta">
                                <div class="icon fa-icon global__icon-secondary"><FaTelegramPlane /></div>
                                <a href="https://t.me/golangetc/{ $router[$page.url.pathname].telegram.message_id }">
                                    telegram post
                                </a>
                            </div>
                        {/if}
                        {#if $router[$page.url.pathname] && $router[$page.url.pathname].tags.author }
                            <div class="meta">
                                <div class="icon di-icon global__icon-secondary"><DiGithubAlt /></div>
                                <a href="https://github.com/{ $router[$page.url.pathname].tags.author }">
                                    { $router[$page.url.pathname].tags.author }
                                </a>
                            </div>
                        {/if}
                    </div>
                </div>
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
            </div>
        </div>
    </Content>
<Footer/>

<style>
    .date {
        font-size: 1em;
        padding-bottom: 12px;
    }
    .inner-container {
        flex-direction: row-reverse;
        min-width: 100%;
        display: flex;
        width: 100%;
        gap: 20px;
    }
    .content {
        justify-content: center;
        padding: 0 10%;
        display: flex;
    }
    .metadata {
        flex-shrink: 0;
        width: 240px;
    }
    .article {
        width: calc(100% - 260px);
        flex-grow: 1;
    }

    .meta {
        flex-direction: row;
        align-items: center;
        margin-right: 8px;
        padding: 2px 0;
        display: flex;
    }
    .code-btn{
        justify-content: flex-end;
        padding: 4px 0 4px 0;
        display: flex;
    }
    .icon{
        padding: 4px;
        height: 20px;
        width: 20px;
    }

    @media (max-width: 1020px) {
        .content {
            font-size: .9em;
        }
        .inner-container {
            flex-direction: column;
            gap: 10px;
        }
        .article, .metadata {
            width: 100%;
        }
    }
    @media (max-width: 768px) {
        .content {
            padding: 0;
        }
    }
</style>