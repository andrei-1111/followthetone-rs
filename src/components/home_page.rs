use leptos::*;

#[component]
pub fn HomePage() -> impl IntoView {
    view! {
        <div class="hero min-h-screen bg-base-200">
            <div class="hero-content text-center">
                <div class="max-w-md">
                    <h1 class="text-5xl font-bold">"FollowTheTone"</h1>
                    <p class="py-6">
                        "Your comprehensive guitar database and catalog.
                        Explore detailed information about guitars, their specifications, and more."
                    </p>
                    <a class="btn btn-primary" href="/guitars">
                        "Browse Guitars"
                    </a>
                </div>
            </div>
        </div>
    }
}
