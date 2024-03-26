<script>
  import FaTelegramPlane from 'svelte-icons/fa/FaTelegramPlane.svelte';
  import MdAccessTime    from 'svelte-icons/md/MdAccessTime.svelte';
  import DiGithubAlt     from 'svelte-icons/di/DiGithubAlt.svelte';

  export let meta;
  export let url;

  function formatDate(timestamp) {
    const date = new Date(timestamp * 1000);
    const day = date.getDate().toString().padStart(2, '0');
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear().toString().slice(-2);
    return `${day}-${month}-${year}`;
  }
</script>

<div class="card border card-color">
    <div class="header">
        <a href="{url}">
            <h2>{meta.static.title}</h2>
        </a>
    </div>
    <div class="body">
        {#if meta.telegram && meta.telegram.date}
            <div class="meta">
                <div class="icon md-icon icon-color"><MdAccessTime /></div>
                { formatDate(meta.telegram.date) }
            </div>
        {/if}
        {#if meta.telegram && meta.telegram.message_id }
            <div class="meta">
                <div class="icon fa-icon icon-color"><FaTelegramPlane /></div>
                <a href="https://t.me/golangetc/{ meta.telegram.message_id }">
                    { meta.telegram.message_id }
                </a>
            </div>
        {/if}
        {#if meta.tags && meta.tags.author }
            <div class="meta">
                <div class="icon di-icon icon-color"><DiGithubAlt /></div>
                <a href="https://github.com/{ meta.tags.author }">
                    { meta.tags.author }
                </a>
            </div>
        {/if}
    </div>
</div>

<style>
    .card {
        padding: 12px;
    }
    .header{
        justify-content: flex-start;
        align-items: center;
        flex-direction: row;
        display: flex;
    }
    .header h2 {
        font-size: 1.2em;
        margin: 0;
    }
    .body {
        flex-direction: row;
        margin-top: 8px;
        display: flex;
        font-size: .9em;
    }
    .meta {
        flex-direction: row;
        align-items: center;
        display: flex;
        margin-right: 8px;
    }
    .icon {
        margin-right: 4px;
    }
    .di-icon {
        width: 20px;
        height: 20px;
    }
    .fa-icon {
        width: 16px;
        height: 16px;
    }
    .md-icon{
        width: 16px;
        height: 16px;
    }

    @media (max-width: 768px) {
        .card {
            padding: 10px
        }
    }
</style>