<template>
    <footer v-if="visible" class="bg-footer">
        <div class="container">
            <div class="card donations-card text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <h5 class="card-title">Bu site deprem bağışlarını hızlandırmak ve kolaylaştırmak için
                            yapılmıştır.
                        </h5>
                        <div class="d-flex justify-content-end" data-bs-theme="dark">
                            <button type="button" class="btn-close" aria-label="Close" @click="hide_footer"></button>
                        </div>
                    </div>
                    <p class="card-text">6 Şubat'ta Türkiye'de meydana gelen deprem sonrasında alabildiğimiz her türlü
                        yardıma ihtiyacımız var. Yukarıdaki aramayı kullanarak bağış yapmak için size uygun kaynağı
                        bulabilir veya insanları bağışlara yönlendirmek için gereken kaynakları kolaylıkla sosyal medya
                        hesaplarınızda paylaşabilirsiniz.</p>
                    <div class="d-flex justify-content-between">
                        <button type="button" class="btn btn-light fw-bold" @click="share_this_site">Bu siteyi
                            paylaş</button>
                        <span class="contact fw-bold" @click="contact">Contact</span>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</template>

<script setup>
import { ref } from 'vue';

const visible = ref(true);

async function hide_footer() {
    visible.value = false;
}

async function contact() {
    window.open("https://github.com/oldventura/deprem", "_blank");
}

async function share_this_site() {
    try {
        await navigator.share({
            title: 'Deprem Bağışı',
            text: 'Deprem Bağışı',
            url: 'https://deprem.kgbtr.org/',
        })
    } catch (err) {
        console.log('Error sharing', err)
        navigator.clipboard.writeText('https://deprem.kgbtr.org/')
    }
}
</script>