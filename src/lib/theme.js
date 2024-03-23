import { getCookie, setCookie } from './cookie.js';
import { writable } from 'svelte/store';

const defaultTheme = getCookie('theme') || 'light';
export const theme = writable(defaultTheme);

theme.subscribe(value => {
  if (typeof window !== "undefined") {
    document.body.className = value;
    setCookie('theme', value);
  }
});