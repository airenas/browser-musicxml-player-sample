<template>
  <div id="app">
    <FileInput/>
    <MusicXMLPlayer/>
  </div>
</template>

<script>
import FileInput from './components/FileInput'
import MusicXMLPlayer from './components/MusicXMLPlayer'

export default {
  name: 'App',
  components: {
    FileInput,
    MusicXMLPlayer,
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
