function hr_size(value) {
    if(value > 1024^4) {
        return sprintf("%7.2f TB", value / (1024^4));
    } else if(value > 1024^3) {
        return sprintf("%7.2f GB", value / (1024^3));
    } else if(value > 1024^2) {
        return sprintf("%7.2f MB", value / (1024^2));
    } else if(value > 1024) {
        return sprintf("%7.2f KB", value / (1024.0));
    } else {
        return sprintf("%7d B ", value);
    }
}