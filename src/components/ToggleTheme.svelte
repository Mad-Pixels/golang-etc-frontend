<script>
  import IoIosMoon from 'svelte-icons/io/IoIosMoon.svelte';
  import IoMdSunny from 'svelte-icons/io/IoMdSunny.svelte';
  import { fade } from 'svelte/transition';
  import { theme } from '$lib/theme.js';

  function toggleTheme() {
    theme.update(currentTheme => currentTheme === 'light' ? 'dark' : 'light');
  }
  let currentTheme;
  theme.subscribe(value => currentTheme = value);
</script>

<div class="theme-toggle border {currentTheme}" on:click={toggleTheme}>
    {#if currentTheme === 'light'}
        <div class="toggle-icon light-theme-icon icon-color" in:fade={{ duration: 500 }}>
            <IoMdSunny />
        </div>
    {/if}
    {#if currentTheme === 'dark'}
        <div class="toggle-icon dark-theme-icon" in:fade={{ duration: 500 }}>
            <IoIosMoon />
        </div>
    {/if}
</div>

<style>
    .theme-toggle {
        justify-content: center;
        align-items: center;
        position: relative;
        margin: 0 0 0 16px;
        cursor: pointer;
        display: flex;
        width: 24px;
        height: 24px;
        padding: 6px;
    }
    .toggle-icon {
        position: absolute;
        transition: opacity 0.5s;
    }
    .light-theme-icon, .dark-theme-icon {
        height: 24px;
        width: 24px;
    }
</style>