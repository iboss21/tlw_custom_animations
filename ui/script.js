let animations = {};
let currentCategory = 'all';

// Listen for messages from Lua
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch(data.action) {
        case 'open':
            openMenu(data.animations);
            break;
        case 'close':
            closeMenu();
            break;
    }
});

// Open the menu and populate animations
function openMenu(animData) {
    animations = animData;
    document.getElementById('animation-menu').classList.remove('hidden');
    populateAnimations();
    setupCategoryButtons();
}

// Close the menu
function closeMenu() {
    document.getElementById('animation-menu').classList.add('hidden');
    fetch(`https://${GetParentResourceName()}/closeMenu`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

// Stop current animation
function stopAnimation() {
    fetch(`https://${GetParentResourceName()}/stopAnimation`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

// Request animation
function requestAnimation(animKey) {
    fetch(`https://${GetParentResourceName()}/requestAnimation`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ animationKey: animKey })
    });
    closeMenu();
}

// Populate animations list
function populateAnimations() {
    const list = document.getElementById('animations-list');
    list.innerHTML = '';
    
    for (const [key, anim] of Object.entries(animations)) {
        // Auto-determine category based on animation properties
        let animCategory = 'standing';
        if (anim.nededBeds) {
            animCategory = 'bed';
        } else if (anim.nededChair) {
            animCategory = 'chair';
        } else if (anim.category) {
            animCategory = anim.category;
        } else if (anim.label && (anim.label.toLowerCase().includes('romantic') || anim.label.toLowerCase().includes('kiss'))) {
            animCategory = 'romantic';
        }
        
        // Filter by category
        if (currentCategory !== 'all' && animCategory !== currentCategory) {
            continue;
        }
        
        const item = document.createElement('div');
        item.className = 'animation-item';
        
        // Add special styling for animations that need props
        if (anim.nededBeds || anim.nededChair) {
            item.classList.add('needs-prop');
        }
        
        // Build requirement text
        let reqText = '';
        if (anim.nededBeds) {
            reqText = 'Requires: Bed 🛏️';
        } else if (anim.nededChair) {
            reqText = 'Requires: Chair 💺';
        }
        
        item.innerHTML = `
            <div class="animation-name">${anim.label}</div>
            <div class="animation-category">${animCategory}</div>
            ${reqText ? `<div class="animation-req">${reqText}</div>` : ''}
        `;
        
        item.addEventListener('click', () => requestAnimation(key));
        list.appendChild(item);
    }
}

// Setup category button handlers
function setupCategoryButtons() {
    const buttons = document.querySelectorAll('.category-btn');
    buttons.forEach(btn => {
        btn.addEventListener('click', function() {
            // Update active state
            buttons.forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            
            // Update category and refresh list
            currentCategory = this.getAttribute('data-category');
            populateAnimations();
        });
    });
}

// Close menu on ESC key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeMenu();
    }
});

// Get parent resource name
function GetParentResourceName() {
    let resourceName = 'tlw_custom_animations';
    
    // Check if we're in NUI context
    if (window.location.href.includes('nui://')) {
        const match = window.location.href.match(/nui:\/\/([^\/]+)\//);
        if (match) resourceName = match[1];
    }
    
    return resourceName;
}
