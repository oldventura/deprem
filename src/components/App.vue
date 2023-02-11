<template>
    <div class="page d-flex flex-column">
        <Navbar />
        <div class="static-view">
            <Footer />
        </div>
    </div>
</template>

<script setup>
import { onBeforeMount } from "vue";
import Navbar from "./Navbar.vue";
import Footer from "./Footer.vue";

onBeforeMount(() => {
    let vh = window.innerHeight * 0.01;
    // Then we set the value in the --vh custom property to the root of the document
    document.documentElement.style.setProperty('--vh', `${vh}px`);
})
</script>