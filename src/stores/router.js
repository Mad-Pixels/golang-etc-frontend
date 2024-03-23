import { writable } from 'svelte/store';
import contentData from '../routes/content/router.json';

export const router = writable(contentData);