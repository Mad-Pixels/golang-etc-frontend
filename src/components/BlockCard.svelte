<script>
  import FaBuffer from 'svelte-icons/fa/FaBuffer.svelte'

  export let content;
</script>

<div class="card border">
    <div class="header">
        <div class="icon icon-color">
            <FaBuffer />
        </div>
        <a href="{content.static.url}">{content.static.title}</a>
    </div>
    <div class="body">
    </div>
</div>

<style>
    .card {
        padding: 12px;
    }
    .header{
        justify-content: flex-start;
        flex-direction: row;
        display: flex;
    }
    .icon {
        width: 16px;
        height: 16px;
        margin-right: 4px;
    }

    @media (max-width: 768px) {
        .card {
            padding: 8px;
        }
    }
</style>