<script>
  import Header  from  "../../components/general/Header.svelte";
  import Footer  from  "../../components/general/Footer.svelte";
  import Content from "../../components/general/Content.svelte";

  import { onMount }     from "svelte";
  import { writable }    from "svelte/store";
  import { theme }       from "$lib/theme.js";
  import { getDateTime } from "$lib/format_date.js";
  import { formatConsole }  from "$lib/format_html.js";
  import { hello_world } from "../../stores/playground_start.js";
  import { versions }    from "../../stores/playground_versions.js";
  import { Split }       from "@geoffcox/svelte-splitter"

  let playground_url = "https://srv516648.hstgr.cloud/api/v1/playground";
  let theme_light    = "/src/theme_editor/light.json";
  let theme_dark     = "/src/theme_editor/dark.json";

  let currentTheme = writable('light');
  let waiter = writable(false);
  let result = writable("");
  let editorContainer;
  let resizeListener;
  let editor;

  let selected = versions[0].golang;
  let code = hello_world;

  onMount(() => {
    theme.subscribe(value => {
      currentTheme.set(value);
      loadEditor();
    });
  });

  async function loadEditor() {
    const monaco = await import('monaco-editor');
    if (editor) { editor.dispose(); }

    fetch($currentTheme === 'dark' ? theme_dark : theme_light)
      .then(data => data.json())
      .then(data => {
        monaco.editor.defineTheme('playground', data);
        monaco.editor.setTheme('playground');
      });
    editor = monaco.editor.create(editorContainer, {
      minimap: { enabled: window.innerWidth > 768 },
      language: 'go',
      value: code,
    });

    if (!resizeListener) {
      resizeListener = () => {
        editor.layout();
        editor.updateOptions({
          minimap: { enabled: window.innerWidth > 768 }
        });
      };
      window.addEventListener('resize', resizeListener);
    }
    function updateEditorLayout() {if (editor) { editor.layout(); }}
    window.addEventListener('resize', updateEditorLayout);
  }

  async function sendCode() {
    waiter.set(true);
    result.set("");

    const code = editor.getValue();
    const encodedCode = btoa(code);
    const response = await fetch(playground_url, {
      method:  "POST",
      headers: {"Content-Type": "application/json"},
      body:    JSON.stringify({version: selected, source: encodedCode})
    });
    const data = await response.json();
    const date = getDateTime();

    result.set(formatConsole(`${date}:<br>\n${data.data}`));
    waiter.set(false);
  }
</script>

<svelte:head>
    <title>GoLang etc.</title>
</svelte:head>

<Header/>
<Content>
    <div class="title">
        <h1>Playground</h1>
        <div class="manage_board">
            <button on:click={sendCode} class="global__btn-main btn_run { $waiter ? 'global__btn-disabled' : '' }" disabled={$waiter}>execute</button>
            <select bind:value={selected} class="global__btn-secondary global__btn-select btn_select">
                {#each versions as version}
                    <option value={version.golang}>{version.golang}</option>
                {/each}
            </select>
        </div>
    </div>
    <div class="ide">
        <Split class="ide" horizontal initialPrimarySize="80%" resetOnDoubleClick >
            <div slot="primary" class="editor" bind:this={editorContainer}></div>
            <div slot="secondary" class="editor">{@html $result}</div>
        </Split>
    </div>
</Content>
<Footer/>

<style>
    h1 {
        margin-top: 0;
    }
    .title{
        display: flex;
        align-items: center;
        flex-direction: row;
        justify-content: space-between;
    }
    .manage_board{
        gap: 12px;
        display: flex;
        align-items: center;
        padding: 0 0 18px 0;
        flex-direction: row-reverse;
    }
    .btn_run {
        padding: 8px 12px 8px 12px;
    }
    .btn_select {
        padding: 6px 6px 6px 6px;
    }
    .ide {
        width: 100%;
        height: 76vh;
    }
    .editor{
        width: 100%;
        height: 76vh;
    }

    @media (max-width: 768px) {
        h1 {
            display: none;
        }
        .editor {
            height: 30vh;
        }
    }
</style>