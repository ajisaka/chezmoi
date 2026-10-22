import React, { Dispatch, SetStateAction, useContext, useState } from 'react'

export type AppState = {
  value: number
}

const initialState: AppState = {
  value: 0,
}

const AppStateContext = React.createContext<AppState>(initialState);
const SetAppStateContext = React.createContext<Dispatch<SetStateAction<AppState>>>(() => {})

export function useAppState() {
  return useContext(AppStateContext)
}

export function useSetAppState() {
  return useContext(SetAppStateContext)
}

export function AppStateProvider(props: {
  initialState?: AppState;
  children: React.ReactNode;
}) {
  const [state, setState] = useState<AppState>(
    props.initialState ?? initialState
  )
  return (
    <AppStateContext.Provider value={state}>
      <SetAppStateContext.Provider value={setState}>
        {props.children}
      </SetAppStateContext.Provider>
    </AppStateContext.Provider>
  )
}
