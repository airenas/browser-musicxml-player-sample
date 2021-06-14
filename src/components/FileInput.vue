<template>
  <div class="finput">
    <div style="border: solid 1px green; margin: 5px; padding: 5px">
      <span>Select music XML file:</span>
      <input id="input" type="file" @change="fileChange" />
    </div>
  </div>
</template>

<script>
import { bus } from '../main'

export default {
  name: 'FileInput',
  data () {
    return {
      file: null
    }
  },
  methods: {
    fileChange (event) {
      console.log(event.target.files)
      bus.$emit('fileChange', event.target.files[0])
    }
  }
}
</script>

<style scoped>
</style>
