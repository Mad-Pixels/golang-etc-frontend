<script>
  import Header         from "../components/general/Header.svelte";
  import Footer         from "../components/general/Footer.svelte";
  import Content        from "../components/general/Content.svelte";
  import BlockDashboard from "../components/BlockDashboard.svelte";

  import { router } from '../stores/router';
</script>

<svelte:head>
    <title>GoLang etc.</title>
</svelte:head>

<Header/>
<Content>
    <BlockDashboard metadata={$router} />
</Content>
<Footer/>