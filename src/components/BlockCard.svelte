<script>
  import FaTelegramPlane from 'svelte-icons/fa/FaTelegramPlane.svelte';
  import DiGithubAlt     from 'svelte-icons/di/DiGithubAlt.svelte';
  import FaHashtag       from 'svelte-icons/fa/FaHashtag.svelte';
  import { formatDate }  from '../lib/format_date.js';
  import { lineBreaks }  from '../lib/line_breaks.js';

  export let meta;
  export let url;

</script>

<div class="card global__border-main global__card-main">
    <div class="header">
        <a href="{url}">
            <h2 class="global__break-lines">{lineBreaks(meta.static.title, 50)}</h2>
        </a>
        <div class="header-date">
            {#if meta.telegram && meta.telegram.date}
                { formatDate(meta.telegram.date) }
            {/if}
        </div>
    </div>
    <div class="body">
        {#if meta.telegram && meta.telegram.message_id }
            <div class="meta">
                <div class="icon fa-icon global__icon-secondary"><FaTelegramPlane /></div>
                <a href="https://t.me/golangetc/{ meta.telegram.message_id }">
                    { meta.telegram.message_id }
                </a>
            </div>
        {/if}
        {#if meta.tags && meta.tags.author }
            <div class="meta">
                <div class="icon di-icon global__icon-secondary"><DiGithubAlt /></div>
                <a href="https://github.com/{ meta.tags.author }">
                    { meta.tags.author }
                </a>
            </div>
        {/if}
        {#if meta.tags}
            {#each Object.entries(meta.tags) as [key, value]}
                {#if key !== 'author'}
                    <div class="meta">
                        <div class=" md-icon global__icon-secondary"><FaHashtag /></div>
                        <div class="tag">{value}</div>
                    </div>
                {/if}
            {/each}
        {/if}
    </div>
</div>

<style>
    .card {
        justify-content: space-between;
        flex-direction: column;
        display: flex;
        padding: 12px;
    }
    .header{
        justify-content: space-between;
        align-items: baseline;
        flex-direction: row;
        display: flex;
        width: 100%;
    }
    .header h2 {
        font-size: 1.2em;
        margin: 0;
    }
    .body {
        flex-direction: row;
        flex-wrap: wrap;
        margin-top: 8px;
        font-size: .9em;
        display: flex;
    }
    .meta {
        flex-direction: row;
        align-items: center;
        display: flex;
        margin-right: 8px;
        padding: 2px 0;
    }
    .header-date {
        text-align: right;
        font-size: .8em;
        min-width: 64px;
    }
    .di-icon {
        width: 21px;
        height: 21px;
    }
    .fa-icon {
        width: 16px;
        height: 16px;
    }
    .md-icon{
        width: 14px;
        height: 14px;
    }

    @media (max-width: 768px) {
        .card {
            padding: 10px
        }
    }
</style>