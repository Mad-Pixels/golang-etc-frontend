<script>
  import Header from "../../components/general/Header.svelte";
  import Footer from "../../components/general/Footer.svelte";
  import Content from "../../components/general/Content.svelte";
  import { onMount } from 'svelte';
  import { writable } from 'svelte/store';

  let editor;
  let editorContainer;
  let result = writable("");

  onMount(async () => {
    if (typeof window !== 'undefined') {
      const monaco = await import('monaco-editor');
      editor = monaco.editor.create(editorContainer, {
        value: '// напишите ваш код на Go здесь',
        language: 'go',
        theme: 'vs-dark'
      });
    }
  });

  export function beforeDestroy() {
    if (editor) {
      editor.dispose();
    }
  }

  async function sendCode() {
    const code = editor.getValue();
    const encodedCode = btoa(code);
    const response = await fetch('https://srv516648.hstgr.cloud/api/v1/playground', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        version: "1.22",
        source: encodedCode
      })
    });
    const data = await response.json();
    result.set(data.data); // Обновляем переменную результатами
  }
</script>

<svelte:head>
    <title>GoLang etc.</title>
</svelte:head>

<Header/>
<Content>
    <div id="editor" bind:this={editorContainer}></div>
    <button on:click={sendCode}>Запустить код</button>
    <h2>Результат выполнения:</h2>
    <pre>{$result}</pre> <!-- Блок для отображения результата -->
</Content>
<Footer/>

<style>
    #editor {
        width: 100%;
        height: 500px;
    }
    button {
        margin-top: 20px;
    }
    pre {
        background-color: #f4f4f4;
        padding: 10px;
        border: 1px solid #ccc;
    }
</style>
