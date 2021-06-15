<template>
  <v-app>
    <v-main>
      <FileInput/>
      <MusicXMLPlayer />
    </v-main>
  </v-app>
</template>

<script>
import FileInput from './components/FileInput.vue';
import MusicXMLPlayer from './components/MusicXMLPlayer.vue';

export default {
  name: 'App',

  components: {
    MusicXMLPlayer,
    FileInput,
  },

  data: () => ({
    //
  }),
};
</script>

<style lang="sass" scoped>

</style>