const initActionCable = () => {
  const mots = document.getElementById('word-grid');
  if (mots) {
    const gameId = mots.dataset.game
    App[`game_${gameId}`] = App.cable.subscriptions.create(
      { channel: 'GamesChannel', game_id: gameId },
      { received: (data) => console.log(data) }
      )
  }
}

export { initActionCable };
