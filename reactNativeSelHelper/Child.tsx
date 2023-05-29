import React from 'react';
import { ScrollView, Text, View, Button } from "react-native";
import { Card } from "react-native-elements";
import useFetch from "./lib/useFetch";
import { StyleSheet } from "react-native";

interface ChildProps {
    navigation: any,
    route: any; // assuming you're passing route prop from a navigator
}

const styles = StyleSheet.create({
    titleText: {
        fontSize: 20,
        fontWeight: "bold",
        paddingBottom: 10,
    },
});

const Child : React.FC<ChildProps> = ({ navigation, route: { params } }) => {
    const { search } = params;
    const { data, loading, error } = useFetch(
        `https://joke.deno.dev/type/${search}`
    );

    if (loading)
        return (
            <View>
                <Text>Loading</Text>
            </View>
        );
    else if (error)
        return (
            <View>
                    <Text>Error!</Text>
                    <Text>{JSON.stringify(error)}</Text>
            </View>
        );
    else if (data) {
        const mydata = data as string[];
        return (
            <ScrollView>
                <View>
                    <Text style={styles.titleText}>Jokes</Text>
                    {mydata.map((joke: any, index: number) => (
                        <div key={index}>
                            <h1>{joke.setup}</h1>
                            <hr />
                            <p>{joke.punchline}</p>
                        </div>
                    ))}
                </View>
            </ScrollView>
        );
    } else {
        return (
            <View>
                <Text>Nothing to show!</Text>
            </View>
        );
    }
};

export default Child;
