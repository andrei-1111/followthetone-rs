use leptos::*;
use leptos_meta::*;

#[component]
pub fn Layout(children: Children) -> impl IntoView {
    view! {
        <Html lang="en" dir="ltr" attr:data-theme="light"/>
        <Title text="FollowTheTone - Guitar Database"/>
        <Meta charset="utf-8"/>
        <Meta name="viewport" content="width=device-width, initial-scale=1"/>
        <Meta name="description" content="Guitar database and catalog"/>

        <nav class="navbar bg-base-100 shadow-lg">
            <div class="flex-1">
                <a class="btn btn-ghost text-xl" href="/">
                    "FollowTheTone"
                </a>
            </div>
            <div class="flex-none">
                <ul class="menu menu-horizontal px-1">
                    <li><a href="/">"Home"</a></li>
                    <li><a href="/guitars">"Guitars"</a></li>
                </ul>
            </div>
        </nav>

        <main class="container mx-auto px-4 py-8">
            {children()}
        </main>
    }
}
