<script>
  import FaTelegramPlane from 'svelte-icons/fa/FaTelegramPlane.svelte';
  import DiGithubBadge   from 'svelte-icons/di/DiGithubBadge.svelte';
  import ToggleTheme     from '../ToggleTheme.svelte';
</script>

<header>
    <div class="container-block">
        <div class="header">
            <a href="/" class="logo global__logo-main">
                <svg viewBox="16.8 16.1 72.9 27.6" xmlns="http://www.w3.org/2000/svg"><switch><g fill="currentColor"><path d="m22.3 24.7c-.1 0-.2-.1-.1-.2l.7-1c.1-.1.2-.2.4-.2h12.6c.1 0 .2.1.1.2l-.6.9c-.1.1-.2.2-.4.2zm-5.3 3.2c-.1 0-.2-.1-.1-.2l.7-1c.1-.1.2-.2.4-.2h16.1c.1 0 .2.1.2.2l-.3 1c0 .1-.2.2-.3.2zm8.5 3.3c-.1 0-.2-.1-.1-.2l.5-.9c.1-.1.2-.2.4-.2h7c.1 0 .2.1.2.2l-.1.8c0 .1-.1.2-.2.2zm36.6-7.2-5.9 1.5c-.5.1-.6.2-1-.4-.5-.6-.9-1-1.7-1.3-2.2-1.1-4.4-.8-6.4.5-2.4 1.5-3.6 3.8-3.6 6.7 0 2.8 2 5.1 4.8 5.5 2.4.3 4.4-.5 6-2.3.3-.4.6-.8 1-1.3h-6.8c-.7 0-.9-.5-.7-1.1.5-1.1 1.3-2.9 1.8-3.8.1-.2.4-.6.9-.6h12.8c-.1 1-.1 1.9-.2 2.9-.4 2.5-1.3 4.9-2.9 6.9-2.5 3.3-5.8 5.4-10 6-3.5.5-6.7-.2-9.5-2.3-2.6-2-4.1-4.6-4.5-7.8-.5-3.8.7-7.3 3-10.3 2.5-3.3 5.8-5.4 9.9-6.1 3.3-.6 6.5-.2 9.3 1.7 1.9 1.2 3.2 2.9 4.1 5 .1.4 0 .5-.4.6z"/><path d="m73.7 43.5c-3.2-.1-6.1-1-8.6-3.1-2.1-1.8-3.4-4.1-3.8-6.8-.6-4 .5-7.5 2.9-10.6 2.6-3.4 5.7-5.1 9.9-5.9 3.6-.6 7-.3 10 1.8 2.8 1.9 4.5 4.5 5 7.9.6 4.8-.8 8.6-4 11.9-2.3 2.4-5.2 3.8-8.4 4.5-1.1.2-2.1.2-3 .3zm8.4-14.2c0-.5 0-.8-.1-1.2-.6-3.5-3.8-5.5-7.2-4.7-3.3.7-5.4 2.8-6.2 6.1-.6 2.7.7 5.5 3.2 6.7 1.9.8 3.9.7 5.7-.2 2.9-1.4 4.4-3.7 4.6-6.7z"/></g></switch></svg>
            </a>
            <div class="nav">
                <div class="nav-icon">
                    <a href="https://github.com/Mad-Pixels/golang-etc">
                        <div class="icon icon-gh global__icon-main global__border-main">
                            <DiGithubBadge />
                        </div>
                    </a>
                    <a href="https://t.me/golangetc">
                        <div class="icon icon-tg global__icon-main global__border-main">
                            <FaTelegramPlane />
                        </div>
                    </a>
                </div>
                <ToggleTheme />
            </div>
        </div>
</header>

<style>
    .header {
        justify-content: space-between;
        align-items: center;
        display: flex;
        width: 100%;
    }
    .logo {
        width: 100px;
        height: 38px;
    }
    .nav {
        flex-direction: row;
        align-items: center;
        display: flex;
    }
    .nav-icon {
        flex-direction: row;
        align-items: center;
        display: flex;
    }
    .icon {
        margin: 0 4px 0 4px;
        cursor: pointer;
    }
    .icon-gh {
        padding: 2px;
        height: 32px;
        width: 32px;
    }
    .icon-tg {
        padding: 6px;
        height: 24px;
        width: 24px;
    }

    @media (max-width: 380px) {
        .logo {
            display: none;
        }
        .nav {
            justify-content: space-between;
            flex-grow: 1;
        }
        .icon {
            margin: 0 8px 0 0;
        }
    }
</style>