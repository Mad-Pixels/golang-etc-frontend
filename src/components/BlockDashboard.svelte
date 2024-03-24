<script>
  import BlockCard from "./BlockCard.svelte";
  export let content = [];
</script>

<div class="cards">
    {#each content as article}
        <BlockCard content={article} />
    {/each}
</div>

<style>
    .cards {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(min(100%, 360px), 1fr));
        gap: 1em;
    }
</style>