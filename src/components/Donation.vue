<template>
    <div class="card border-dark shadow-lg">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="card-title fw-bold m-0">{{ props.data.name }}</h5>
                <span class="badge bg-dark">{{ props.data.lang }}</span>
            </div>
            <div class="d-flex flex-column mb-3">
                <button class="btn btn-primary mb-1" @click="donate">Bağış yap!</button>
                <button class="btn btn-dark" @click="show_share">Paylaş</button>
            </div>
            <div class="d-flex">
                <div v-show="props.data.options.includes('bank')" class="m-2">
                    <span class="bi bi-bank2"></span>
                </div>
                <div v-show="props.data.options.includes('card')" class="m-2">
                    <span class="bi bi-credit-card-fill"></span>
                </div>
                <div v-show="props.data.options.includes('crypto')" class="m-2">
                    <span class="bi bi-currency-bitcoin"></span>
                </div>
                <div v-show="props.data.options.includes('paypal')" class="m-2">
                    <span class="bi bi-paypal"></span>
                </div>
                <div v-show="props.data.options.includes('phone')" class="m-2">
                    <span class="bi bi-phone-fill"></span>
                </div>
            </div>
        </div>

    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
const emit = defineEmits(['share']);

async function show_share() {
    emit('share', props.data);
}

async function donate() {
    window.open(props.data.link, '_blank');
}

const props = defineProps({
    data: {
        type: Object,
        required: true
    }
})

</script>