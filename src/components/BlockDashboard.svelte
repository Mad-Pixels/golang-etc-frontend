<script>
  import BlockCard from "./BlockCard.svelte";
  export let metadata = {};
</script>

<div class="cards">
    {#each Object.entries(metadata) as [key, value]}
        <BlockCard url={key} meta={value} />
    {/each}
</div>

<style>
    .cards {
        grid-template-columns: repeat(auto-fill, minmax(min(100%, 360px), 1fr));
        display: grid;
        gap: 1em;
    }
</style>