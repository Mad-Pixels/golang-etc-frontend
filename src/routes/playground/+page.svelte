<script>
  import Header from "../../components/general/Header.svelte";
  import Footer from "../../components/general/Footer.svelte";
  import Content from "../../components/general/Content.svelte";
  import { onMount, onDestroy } from 'svelte';
  import { writable } from 'svelte/store';

  let editor;
  let editorContainer;
  let result = writable("");

  onMount(() => {
    const monacoPromise = import('monaco-editor');

    monacoPromise.then(monaco => {
      editor = monaco.editor.create(editorContainer, {
        value: '// напишите ваш код на Go здесь',
        language: 'go',
        theme: 'vs-dark'
      });

      // Вызовите layout при изменении размера окна
      function updateEditorLayout() {
        if (editor) {
          editor.layout();
        }
      }

      window.addEventListener('resize', updateEditorLayout);

      onDestroy(() => {
        window.removeEventListener('resize', updateEditorLayout);
        if (editor) {
          editor.dispose();
        }
      });
    });
  });

  // function updateEditorLayout() {
  //   if (editor) {
  //     editor.layout();
  //   }
  // }
  // onDestroy(() => {
  //   window.removeEventListener('resize', updateEditorLayout);
  //   if (editor) {
  //     editor.dispose();
  //   }
  // });

  const options = [
    { color: 'red', component: "RedThing" },
    { color: 'green', component: "GreenThing" },
    { color: 'blue', component: "BlueThing" }
  ];
  let selected = options[0];

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
  //


</script>

<svelte:head>
    <title>GoLang etc.</title>
</svelte:head>

<Header/>
<Content>
    <div class="title">
        <h1>Playground</h1>
        <div class="manage_board">
            <button on:click={sendCode} class="global__btn-main btn_run">execute</button>
            <select bind:value={selected} class="global__btn-secondary global__btn-select btn_select">
                {#each options as option}
                    <option value={option}>{option.color}</option>
                {/each}
            </select>
        </div>
    </div>
    <div class="ide">
        <div class="editor" bind:this={editorContainer}></div>
    </div>




    <h2>Результат выполнения:</h2>
    <pre>{$result}</pre> <!-- Блок для отображения результата -->
</Content>
<Footer/>

<style>
    .title{
        display: flex;
        align-items: center;
        flex-direction: row;
        justify-content: space-between;
    }
    .ide{
        flex-direction: column;
        display: flex;
        width: 100%;
    }
    .manage_board{
        gap: 12px;
        display: flex;
        align-items: center;
        padding: 24px 0 24px 0;
        flex-direction: row-reverse;
    }
    .btn_run {
        padding: 8px 12px 8px 12px;
    }
    .btn_select {
        padding: 6px 6px 6px 6px;
    }
    .editor {
        min-height: 200px;
        height: 50vh;
        width: 100%;
        flex: 1;
    }
    pre {
        background-color: #f4f4f4;
        padding: 10px;
        border: 1px solid #ccc;
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