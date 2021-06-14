<template>
  <div class="player">
    <div style="border: solid 1px green; margin: 5px; padding: 5px">
      <div class="at-wrap">
        <div class="at-content">
          <div class="at-viewport" id="at-viewport">
            <div id="at-main" class="at-canvas"></div>
          </div>
        </div>
      </div>
      <div>
        <button v-on:click="play" :disabled="!canPlay">
          {{ playOrPause }}
        </button>
        <button v-on:click="stop" :disabled="!canStop">Stop</button>
      </div>
    </div>
  </div>
</template>

<script>
import { bus } from "../main";

export default {
  name: "MusicXMLPlayer",
  data() {
    return {
      playOrPause: "Play",
      canPlay: false,
      canStop: false,
      playing: false,
      file: {
        type: File,
      },
      at: null,
    };
  },
  created() {
    bus.$on("fileChange", (data) => {
      console.log("File change");
      this.file = data;
      this.setMusicXML(this.file)
    });
  },
  mounted() {
    this.at = this.setupControl();
  },
  methods: {
    setupControl() {
      const updateControls = this.updateControls;
      const fontName = "Ariel";
      const atDiv = document.getElementById("at-main");
      console.log(atDiv);
      const viewPort = document.getElementById("at-viewport");
      console.log("viewPort", viewPort);
      const at = new alphaTab.AlphaTabApi(atDiv, {
        file: "static/la-cucaracha.xml",
        player: {
          scrollOffsetx: -10,
          enablePlayer: true,
          soundFont: "static/soundfont/sonivox.sf2",
          scrollElement: viewPort,
        },
        display: {
          resources: {
            titleFont: "normal 32px " + fontName + ", serif",
            subTitleFont: "normal 20px " + fontName + ", serif",
            wordsFont: "normal 15px " + fontName + ", serif",
            effectFont: "italic 12px " + fontName + ", serif",
            fingeringFont: "normal 14px " + fontName + ", serif",
            markerFont: "bold 14px " + fontName + ", serif",
          },
        },
      });
      at.error.on(function (e) {
        console.error("alphaTab error", e);
      });

      const trackItems = [];
      at.renderStarted.on(function (isResize) {
        if (!isResize) {
          console.log("loading");
        }
        const tracks = new Map();
        at.tracks.forEach(function (t) {
          tracks.set(t.index, t);
        });

        trackItems.forEach(function (trackItem) {
          if (tracks.has(trackItem.track.index)) {
            trackItem.classList.add("active");
          } else {
            trackItem.classList.remove("active");
          }
        });
      });

      at.soundFontLoad.on(function (args) {});
      at.soundFontLoaded.on(function () {});
      at.renderFinished.on(function () {
        console.log("render finish");
        updateControls();
      });
      at.scoreLoaded.on(function (score) {
        console.log("score loaded");
        updateControls();
      });

      at.playerPositionChanged.on(function (args) {});

      const playPauseButton = document.getElementById("play");
      at.playerReady.on(function () {
        console.log("player ready");
        updateControls();
      });

      at.playerStateChanged.on((e) => {
        console.log("stopped", e.stopped, e.state);
        this.playing = e.state == 1;
        if (!this.playing) {
          console.log("Stopped");
        } else {
          console.log("Playing");
        }
        updateControls();
      });
      return at;
    },
    play() {
      this.at.playPause();
    },
    stop() {
      this.at.stop();
    },
    updateControls() {
      this.playOrPause = !this.playing ? "Play" : "Pause";
      this.canPlay = this.at && this.at.isReadyForPlayback;
      this.canStop = this.playing;
    },
    setMusicXML(file) {
      const reader = new FileReader();
      const at = this.at;
      reader.onload = function (data) {
        at.load(data.target.result, [0]);
      };
      reader.readAsArrayBuffer(file);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
