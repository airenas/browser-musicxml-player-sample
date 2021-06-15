<template>
  <v-card>
    <div
      @drop.prevent="onDrop($event)"
      @dragover.prevent="dragClass = 'drag'"
      @dragenter.prevent="dragClass = 'drag'"
      @dragleave.prevent="dragClass = ''"
      :class="{ simple: !dragClass, drag: dragClass }"
    >
      <span>Select music XML file:</span>
      <v-file-input
        counter
        show-size
        truncate-length="50"
        @change="fileChange"
        :value="file"
      ></v-file-input>
    </div>
  </v-card>
</template>

<script>
import { bus } from "../main";

export default {
  name: "FileInput",
  data() {
    return {
      file: null,
      dragClass: "",
    };
  },
  methods: {
    fileChange(file) {
      console.log("File", file);
      bus.$emit("fileChange", file);
    },
    onDrop(e) {
      this.dragClass = "";
      console.log("File", e);
      if (e.dataTransfer.files.length > 0) {
        this.file = e.dataTransfer.files[0];
        bus.$emit("fileChange", e.dataTransfer.files[0]);
      }
    },
  },
};
</script>

<style lang="sass" scoped >
@import '~vuetify/src/styles/main.sass'

.simple
  border: solid 1px map-get($indigo, base)
  margin: 5px
  padding: 5px

.drag
  border: solid 2px map-get($indigo, base)
  margin: 5px
  padding: 5px
</style>
