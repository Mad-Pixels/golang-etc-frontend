<script>
  import Header         from "../components/general/Header.svelte";
  import Footer         from "../components/general/Footer.svelte";
  import Content        from "../components/general/Content.svelte";
  import BlockDashboard from "../components/BlockDashboard.svelte";

  import { router } from '../stores/router';
</script>

<Header/>
<Content>
    <BlockDashboard content={$router} />
</Content>
<Footer/>