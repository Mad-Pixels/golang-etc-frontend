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

<button class="theme-toggle global__btn-main {currentTheme}" on:click={toggleTheme} aria-label="theme switch">
    {#if currentTheme === 'light'}
        <div class="toggle-icon icon" in:fade={{ duration: 700 }}>
            <IoMdSunny />
        </div>
    {/if}
    {#if currentTheme === 'dark'}
        <div class="toggle-icon icon" in:fade={{ duration: 700 }}>
            <IoIosMoon />
        </div>
    {/if}
</button>

<style>
    .theme-toggle {
        justify-content: center;
        align-items: center;
        position: relative;
        margin: 0 0 0 16px;
        cursor: pointer;
        display: flex;
        width: 38px;
        height: 38px;
        padding: 6px;
    }
    .toggle-icon {
        position: absolute;
        transition: opacity 0.5s;
    }
    .icon {
        height: 24px;
        width: 24px;
    }
</style>
