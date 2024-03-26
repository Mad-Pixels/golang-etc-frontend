<script>
  // components.
  import Header    from "../../../components/general/Header.svelte";
  import Content   from "../../../components/general/Content.svelte";
  import Footer    from "../../../components/general/Footer.svelte";

  // static data.
  import { page }   from '$app/stores';
  import { router } from '../../../stores/router.js';
  $: currentPageData = $router[$page.url.pathname] || null;

  // title.
  $: slug = $page.url.pathname.split('/').filter(Boolean).pop();
  $: if (typeof document !== 'undefined' && currentPageData) {
    document.title = currentPageData.static?.title || 'GoLang etc.';
  }

  // highlight.
  import 'highlight.js/styles/github-dark-dimmed.min.css';
  import goLang      from 'highlight.js/lib/languages/go';
  import hljs        from 'highlight.js/lib/core';
  import { onMount } from 'svelte';
  onMount(() => {
    document.querySelectorAll('.article pre code').forEach((block) => {
      hljs.highlightBlock(block);
    });
  });
  hljs.registerLanguage('go', goLang);
  let htmlContent = `{{index . "main.md"}}`
</script>

<Header/>
<Content>
    <div class="article">
        <div class="block-content">
            {@html htmlContent}
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